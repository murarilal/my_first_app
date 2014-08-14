ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
    section "Recent Articles" do
    table_for Article.order("created_at desc").limit(3) do
      column :title do |article|
        link_to article.title, [:admin, article]
      end
      column :created_at
    end
    strong { link_to "View All Articles", admin_articles_path }
  end
  end # content
end
