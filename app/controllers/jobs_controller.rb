class JobsController < ApplicationController
  before_action :set_job,            except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /jobs
  # =link_to .. jobs_path
  def index
    @jobs = if params[:category].blank?
      Job.order created_at: :desc
    else
      Job.joins( :category ).
        where( categories: { name: params[:category] } ).
        order( created_at: :desc )
    end
  end
  # Automatically render jobs/index view

  # GET /jobs/new
  # =link_to .. new_job_path
  def new
    @job = current_user.jobs.new
  end
  # Automatically renders /jobs/new view, which renders _form partial with:
  # =form_for @job ..
  # When @job.new_record? then the resource (i.e. jobs) state transfer
  # html representation is <form action='/jobs' method='post' ..>

  # POST /jobs
  # =form_for @job .. when @job.new_record? then <form action='/jobs' method='post'>
  def create
    @job = current_user.jobs.new( job_params )

    if @job.save
      redirect_to @job, notice: 'Job created.'
    else
      render :new
    end
  end
  # No view for jobs#create; must explicitly redirect_to or render some other view

  # GET /jobs/:id
  # =link_to .. job_path( @job ) | @job
  def show
  end
  # Automatically render jobs/show view

  # GET /jobs/:id/edit
  # =link_to .. edit_job_path( @job ) | [:edit, @job]
  def edit
  end
  # Automatically renders jobs/:id/edit view, which renders _form partial with:
  # =form_for @job ..
  # When @job.persisted? then the resource (i.e. job) state transfer
  # html representation is <form action='/jobs/:id', method='patch' ..>

  # PATCH|PUT /jobs/:id
  # =form_for @job .. when @job.persisted? then <form action='/jobs/:id', method='patch' ..>
  def update
    if @job.update( job_params )
      redirect_to @job, notice:'Job updated.'
    else
      render :edit
    end
  end
  # No view for jobs#update; must explicitly redirect_to or render some other view.

  # DELETE /jobs/:id
  # =link_to .. job_path( @job ) | @job, method: :delete
  def destroy
    @job.destroy
    redirect_to jobs_path, notice:'Job deleted.'
  end
  # No view for jobs#destroy; must explicitly redirect_to some other view

  private
    def set_job
      @job = Job.find( params[:id] )
    end
    def job_params
      params.require( :job ).permit( :title, :description, :company, :url, :category_id )
    end
end
