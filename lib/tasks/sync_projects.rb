require 'nokogiri'
require 'open-uri'
require 'uri'

namespace :sync do
  desc "synchronize projects with gentoo.org"
  task :projects do |t|
    uri = URI("http://www.gentoo.org/proj/en/index.xml?showlevel=3")
    @doc = Nokogiri::HTML(open(uri))
    @projects = @doc.css(".ntable tr")

    prjs = []
    parents = []
    Project.delete_all
    @projects.each do |project|
      if (project = project.css(".tableinfo")).empty?
        parents.clear
        # start from root project
      else
        prj = Project.new
        lines = project.css("td")
        level = 0
        while (prj_name = lines[level].content.strip).empty?
          level += 1
        end
        prj.name = prj_name
        if ! (a = lines[level].css("a")).nil?
          prj.homepage = a.attribute("href").content.strip rescue nil
        end
        if level > 0
          prj.parent_project = parents[level - 1]
        end
        prj.team[:members] = lines[4].content.strip
        prj.team[:leaders] = lines[3].content.strip
        prj.description = lines[5].content.strip
        parents[level] = prj
        prjs << prj
        prj.save
      end
    end

  end
end
