Feature: Inside a Capistrano namespace

  In order to include Rake tasks with descriptions in my Capistrano recipes,
  As a developer using Cape,
  I want to use the Cape DSL.

  Scenario: invoke existing Capistrano DSL methods
    Given a full-featured Rakefile
    And a Capfile with:
      """
      namespace :a_capistrano_namespace do
        Cape do
          desc 'A Capistrano task defined from Cape'
          task :a_capistrano_task_defined_from_cape do
          end
        end
      end
      """
    When I run `cap -T`
    Then the output should contain:
      """
      cap a_capistrano_namespace:a_capistrano_task_defined_from_cape # A Capistrano task defined f...
      """

  @ruby19
  Scenario: verify that existing Capistrano DSL methods are available
    Given a full-featured Rakefile
    And a Capfile with:
      """
      namespace :a_capistrano_namespace do
        Cape do
          [:desc, :task].each do |method|
            if respond_to?(method)
              $stdout.puts "Responds to #{method.inspect}"
            else
              $stdout.puts "Does not respond to #{method.inspect}"
            end
          end
        end
      end
      """
    When I run `cap -T`
    Then the output should contain:
      """
      Responds to :desc
      """
    And the output should contain:
      """
      Responds to :task
      """
