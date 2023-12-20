module AdminSignInSupport
  def admin_sign_in(admin)
    visit '/admin/sign_in'
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'ログイン'
  end
end