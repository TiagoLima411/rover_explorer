class DashboardsController < ApplicationController
  before_action :check_format, only: %i[process_file]

  def new
  end

  def process_file
    Plateau.transaction do
      plateau = Plateau.new
      plateau = set_rovers(plateau, params[:import_file])

      respond_to do |format|
        if plateau.save
          format.html { redirect_to '/dashboards/new', notice: 'Commands created successfully.' }
        else
          notices = []
          plateau.errors.full_messages.each do |error|
            notices << error
          end
            format.html { redirect_to '/dashboards/new', notice: notices }
        end
      end
    end
  end

  def charts_ajax
    mov = { routes: [] }
    Plateau&.last&.rovers&.each do |rover|
      mov[:routes].push(rover.movements)
    end
    render json: mov.as_json
  end

  def check_format
    if ['.txt', ''].include?(File.extname(params[:import_file].original_filename))
      return
    else
      respond_to do |format|
        format.html { redirect_to '/dashboards/new', notice: 'Invalid file format.' }
      end
    end
  end


  private

  def set_rovers(plateau, file)
    arr = plateau.file_to_array(file)
    arr.each_with_index do |line, index|
      if index.eql?(0)
        plateau.size = line
        plateau.axis = plateau.build_axis
      elsif index.odd?
        rover = Rover.new
        rover.position = arr[index]
        rover.comand = arr[index + 1]
        plateau.rovers.push(rover)
      end
    end
    plateau
  end

end
