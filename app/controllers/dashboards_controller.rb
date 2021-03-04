class DashboardsController < ApplicationController

  def new
  end

  def read_file
    plateau = Plateau.new
    plateau = set_rovers(plateau, params[:import_file])
    Plateau.transaction do
      plateau.save
    end

    respond_to do |format|
      if plateau.save
        format.html { redirect_to '/dashboards/new', notice: 'Comandos criados com sucesso.' }
      else
        notices = []
        plateau.errors.full_messages.each do |error|
          notices << error
        end
          format.html { redirect_to '/dashboards/new', notice: notices }
      end
    end
  end

  def charts_ajax
    mov = { routes: [] }
    Plateau.last.rovers.each do |rover|
      mov[:routes].push(rover.movements)
    end
    render json: mov.as_json
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
