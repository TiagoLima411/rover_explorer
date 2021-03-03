class DashboardsController < ApplicationController

  def new
  end

  def read_file
    plateau = Plateau.new
    plateau = set_rovers(plateau, params[:import_file])
    plateau.save

    respond_to do |format|
      if plateau.save
        format.html { redirect_to '/dashboards/new', notice: 'Comandos criados com sucesso.' }
      else
        format.html { redirect_to '/dashboards/new', notice: 'Comandos criados com erro!' }
      end
    end
  end

  private

  def set_rovers(plateau, file)
    arr = plateau.file_to_array(file)

    arr.each_with_index do |line, index|
      if index.eql?(0)
        plateau.size = line.strip
        plateau.axis = plateau.build_axis
      elsif index.odd?
        rover = Rover.new
        rover.position = arr[index].strip
        rover.comand = arr[index + 1].strip
        plateau.rovers.push(rover)
      end
    end
    plateau
  end

end
