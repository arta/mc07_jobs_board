class JobsController < ApplicationController

  # GET /jobs
  # =link_to .. jobs_path
  def  index
    @jobs = Job.all
  end
  # Automatically render jobs/index view
end
