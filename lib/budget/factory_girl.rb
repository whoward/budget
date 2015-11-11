
# add our factory definitions folder to the path and load them
FactoryGirl.definition_file_paths << Pathname(__dir__).join('factories')
FactoryGirl.find_definitions
