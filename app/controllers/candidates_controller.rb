class CandidatesController < ApplicationController

  def index

  end

  def load
    candidate = Candidate.new(params[:uuid])
    @candidate = candidate.save
    redirect_to '/', :notice => "This UUID is not valid, please try again." if not @candidate
  end

  def show
    @candidate = Candidate.load(params[:uuid])
    @view_link = Candidate.view_link(params[:uuid])
    redirect_to '/', :notice => "This UUID is not valid, please try again." if not @candidate

  end

  def new

  end

  def create

  end

  def upload_picture

  end
end
