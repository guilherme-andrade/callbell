# frozen_string_literal: true

require 'dry-rails'

require 'dry/matcher'
require 'dry/matcher/result_matcher'
require 'dry/monads'
require 'dry/monads/do'


Dry::Rails.container do
  config.root = CallbellFullstackAssignment::Application.root
  config.bootable_dirs << CallbellFullstackAssignment::Application.root.join('./config/system')

  map_config = ->(component) { !component.const_path.include?('concerns') }

  config.component_dirs.add 'app/use_cases' do |dir|
    dir.auto_register = map_config
  end

  config.features = %i[controller_helpers]
end
