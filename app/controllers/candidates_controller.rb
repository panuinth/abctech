class CandidatesController < ApplicationController

  def index

  end

  def show
    candidate = Candidate.load(params[:uuid])
    @candidate = Candidate.new({:name => candidate["name"], :age => candidate["age"], :gender => candidate["gender"], :uuid => candidate["uuid"]})
    @view_link = Candidate.view_link(candidate["uuid"])

    if candidate["status"] == -1
      redirect_to '/', :notice => "This UUID is not valid, please try again."
    else
      @notice = params[:notice]
    end
  end

  def new

  end

  def create
    @candidate = Candidate.new(:name => params[:name], :age => params[:age], :gender => params[:gender])

    respond_to do |format|
      if @candidate.save["status"] == 1
        format.html { redirect_to action: "show", notice: "Candidate was successfully created.", :uuid => @candidate.uuid }
      else
        format.html { render action: "new" }
      end
    end
  end

  def load
    candidate = Candidate.new(params[:uuid])
    @candidate = candidate.save
    redirect_to '/', :notice => "This UUID is not valid, please try again." if not @candidate
  end

  def upload_picture

  end

  def update_picture
    @candidate = Candidate.upload_picture(:uuid => params[:uuid], :imageBase64 => params[:imageBase64].tempfile) if not params[:imageBase64].blank?

    respond_to do |format|
      if not params[:imageBase64].blank? and @candidate["status"] == 1
        format.html { redirect_to action: "show", notice: "Candidate was successfully updated.", :uuid => params[:uuid] }
      else
        format.html { redirect_to '/candidates/upload_picture', :notice => "Invalid data, please try again." }
      end
    end

  end

end
