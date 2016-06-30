class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]
  before_action :set_course, only: [:index, :new, :edit, :create]
  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = @course.chapters
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
    @course = @chapter.course
  end

  # GET /chapters/new
  def new
    @chapter = Chapter.new
    @chapter = current_user.chapters.build
  end

  # GET /chapters/1/edit
  def edit
    @chapter = @course.chapters.find(params[:id])
  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = @course.chapters.new(chapter_params)
    @chapter = current_user.chapters.build(chapter_params)
    respond_to do |format|
      if @chapter.save
        format.html { redirect_to [@chapter.course], notice: 'Chapter was successfully created.' }
        format.json { render :show, status: :created, location: @chapter }
      else
        format.html { render :new }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1
  # PATCH/PUT /chapters/1.json
  def update
    @chapter = @course.chapters.find(params[:id])
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to([@chapter.post, @chapter], notice: 'Chapter was successfully updated.') }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { render :edit }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @course = @chapter.course
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to chapters_url, notice: 'Chapter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:course_id, :chapter_title, :description)
    end
end
