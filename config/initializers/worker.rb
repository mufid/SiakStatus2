# Start worker if not in IRB mode
# SiakWorker.new.start unless defined?(IRB)

if not defined?(IRB)
  Rails.logger.info "[WORKER] Retrieving data"
  scheduler = Rufus::Scheduler.start_new

  scheduler.every '10s', blocking: true, allow_overlapping: false do
    # Worker for status retrieval
    retrieval = StatusRetrieval.new(ENV["siak_username"], ENV["siak_password"])
    retrieval.perform.save
    ActiveRecord::Base.connection_pool.release_connection
    
    # Worker for database cleanup
    next if SiakStatus.count < 7000
    old_records = SiakStatus.find(:all, :order => 'created_at ASC', :limit => 5).collect(&:id)
    SiakStatus.delete_all(old_records)
  end
end