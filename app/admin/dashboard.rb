ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    #div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #  span :class => "blank_slate" do
    #    span "Welcome to Active Admin. This is the default dashboard page."
    #    small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
    #  end
    #end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent registered users" do
          table_for User.order("id DESC").limit(10) do |t|
            t.column("Name"){|u| link_to u.name, admin_user_path(u)}
            t.column("Email"){|u| u.email}
            t.column("Role"){|u| status_tag(u.workflow_state)}
          end
        end
      end
      
      column do
        panel "User submitted questions" do
          table_for Question.unscoped.where(workflow_state: :new) do |t|
            t.column("Author"){|q| link_to q.user.name, admin_user_path(q.user)}
            t.column("Title"){|q| link_to q.title, admin_question_path(q) } 
            t.column("Group"){|q| q.group.name }
          end
        end
      end
    end
    columns do
      column do
        panel "Recent comments" do
          ul do
            Comment.order("id DESC").limit(5).map do |comment|
              li do
                para link_to "by #{comment.user.name}", comment.commentable
                para markdown comment.comment
              end
            end
          end
        end
      end
    end
  end # content
end
