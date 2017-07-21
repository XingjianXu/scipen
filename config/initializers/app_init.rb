unless User.find_by_role :admin
  admin_user = User.find_or_create_by(email: Config.app.admin.email)
  admin_user.password = '12345678'
  admin_user.password_confirmation = '12345678'
  admin_user.role = :admin
  admin_user.save
end

Article.create_homepage! unless Article.homepage
