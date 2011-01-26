Given /^I am logged as an admin$/ do
  @admin_company = Company.find_by_role("admin")
  if !@admin_company
    @admin_company = Factory(:company, :role => "admin")
    @admin_company.update_attribute(:confirmation_token, nil)
    @admin_company.update_attribute(:confirmed_at, Time.now)
  end
  visit new_company_session_path
  fill_in "company_email", :with => @admin_company.email
  fill_in "company_password", :with => @admin_company.password
  click_button "company_submit"
end

Given /^I am logged as a "([^"]*)"$/ do |email|
  @company = Company.find_by_email(email)
  @company.update_attribute(:confirmation_token, nil)
  @company.update_attribute(:confirmed_at, Time.now)
  visit new_company_session_path
  fill_in "company_email", :with => email
  fill_in "company_password", :with => "justme"
  click_button "company_submit"
end

Given /^there is a company with name "([^"]*)" in city "([^"]*)"$/ do |name, city|
  @company = Factory(:company, :title => name, :city => city)
end

Given /^there is a company with name "([^"]*)" in city "([^"]*)" and email "([^"]*)"$/ do |name, city, email|
  @company = Factory(:company, :title => name, :city => city, :email => email)
end

Given /^there is a job vacancy with title "([^"]*)" created by "([^"]*)"$/ do |title, email|
  @company = Company.find_by_email(email)
  if !@company
    @company = Factory(:company, :email => email)
  end
  @job = Factory(:job, :company => @company, :title => title)
end

