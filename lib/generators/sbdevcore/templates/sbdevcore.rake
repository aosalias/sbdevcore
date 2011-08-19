namespace :sbdevcore do
  task :load_core_seeds do
    Sbdevcore::Engine.load_seed
  end
end
