# devise_for :admin_users, ActiveAdmin::Devise.config

# namespace :site1 do
#   devise_for :admin_users, ActiveAdmin::Devise.config
# end
#
# namespace :site2 do
#   devise_for :admin_users, ActiveAdmin::Devise.config
# end
#
# namespace :site3 do
#   namespace :demo do
#     devise_for :admin_users, ActiveAdmin::Devise.config
#   end
# end

# [[:site1], [:site2], [:site3, :demo]].map { |namespace| namespace.reverse.inject(active_admin_devise_proc) { |n, c| Proc.new{ namespace c, &n } } }

def multi_active_admin_devise(*namespaces)
  namespaces.each do |namespace|
    namespace.reverse.inject(-> { devise_for :admin_users, ActiveAdmin::Devise.config }) { |n, c| Proc.new { namespace c, &n } }.call
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admin_users, ActiveAdmin::Devise.config
  multi_active_admin_devise([:site1], [:site2], [:site3, :demo])

  ActiveAdmin.routes(self)
end
