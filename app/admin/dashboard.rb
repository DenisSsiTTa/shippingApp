ActiveAdmin.register_page "Dashboard" do

  #Charts



  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      h1 b "Bienvenido Active Admin"
      hr
      br
    end

    columns do
      panel "Graficos" do
        render 'shared/admin/charts_publications'
      end
    end

    columns do
      column do
        panel "Ultimas publicaciones creadas" do
          ul do
            Publication.last(5).each do |publication|
              li link_to(publication.title, admin_publication_path(publication))
            end
          end
        end
      end
      column do
        panel "Listado de Usuarios" do
          ul do
            li b "Total Usuarios: #{User.count + AdminUser.count}"
            li i "Super Administradores registrados: #{AdminUser.count}"
            li i "Usuarios Administradores: #{User.where(role: "admin").count}"
            li i "Usuarios Normales: #{User.where(role: "normal").count}"
            li i "Usuarios Invitados: #{User.where(role: "guest").count}"
            render 'shared/admin/chart_user'
          end
        end
      end
    end
    columns do
      column do
        panel "Grafico Categorias" do
          render 'shared/admin/chart_category'
        end
      end
      column do
        panel "Grafico Envios" do
          render 'shared/admin/chart_type'
        end
      end
    end
  end # content
end
