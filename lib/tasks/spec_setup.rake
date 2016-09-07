namespace :govuk_pay_api_client do
  desc 'Copy the shared examples for govuk pay api rspec testing'
  task :install_shared_examples
    source = File.join(
      Gem.loaded_specs['govuk-pay-api-client'].full_gem_path,
      'shared_examples',
      'shared_examples_for_govpay.rb'
    )
    target = File.join(Rails.root, 'spec', 'support', 'shared_examples_for_govpay.rb')
    FileUtils.cp_r source, target
end
