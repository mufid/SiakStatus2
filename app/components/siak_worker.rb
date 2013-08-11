class SiakWorker
  def work_retrieve
      retrieval = StatusRetrieval.new(ENV["siak_username"], ENV["siak_password"])
      retrieval.perform.save
      nil
  end
  def self.call(job)
    # Worker for status retrieval
    retrieval = StatusRetrieval.new(ENV["siak_username"], ENV["siak_password"])
    retrieval.perform.save
    ActiveRecord::Base.connection_pool.release_connection
    
    # Worker for database cleanup
    return if SiakStatus.count < 7000
    old_records = SiakStatus.find(:all, :order => 'created_at ASC', :limit => 5).collect(&:id)
    SiakStatus.delete_all(old_records)
  end
end
