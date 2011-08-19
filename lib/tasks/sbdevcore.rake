namespace :sbdevcore do
  task :load_core_seeds do
    SbdevCore::Engine.load_seed
  end
end
