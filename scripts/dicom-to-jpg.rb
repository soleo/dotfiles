# CONVERT DICOM IMAGES TO JPG
# Needs Imagemagick, plus the Rmagic and Dicom gems:
#$ gem install rmagick
#$ gem install dicom
#$ gem install prawn
require "prawn"
require 'dicom'
include DICOM
# Change the log level so that only error messages are displayed:
DICOM.logger.level = Logger::ERROR
# Setting up a simple file log:
l = Logger.new('my_logfile.log')
DICOM.logger = l


files = Dir.glob("/Users/xinjiang/Documents/MRI-Xinjiang/DICOM/PA1/ST1/*/*")
puts files.length
files.each do |f|
    if !File.directory? f then
        dcm = DObject.read(f)
        if dcm.read?
            dcm.summary
            
            dcm_image = dcm.image
            dcm_image.normalize.write(f + ".jpg")
        end
    end
end

image_list = Magick::ImageList.new
files = Dir.glob("/Users/xinjiang/Documents/MRI-Xinjiang/DICOM/PA1/ST1/*/*{.jpg}")
puts files.length
files.each do |f|
    if !File.directory? f then
        image_list.read f
    end
end
image_list.write("images.pdf")
for number in 1..7 do
    image_list2 = Magick::ImageList.new
    print number,  " "
    files = Dir.glob("/Users/xinjiang/Documents/MRI-Xinjiang/DICOM/PA1/ST1/SE" + number.to_s + "/*{.jpg}")
    files.each do |f|
        if !File.directory? f then
            image_list2.read f
        end
    end
    newImage = image_list2.append true
    newImage.write "SE" + number.to_s + ".jpg"
end

info = {
 :Title => "Xinjiang's Brain MRI T2",
 :Author => "Xinjiang Shao",
 :Subject => "MRI Scan",
 :Keywords => "MRI PDF",
 :Creator => "Xinjiang",
 :Producer => "Prawn",
 :CreationDate => Time.now
}
Prawn::Document.generate("Xinjiang-MRI-Report.pdf", :info => info) do
    move_down 20
    font("Courier") do
        text "MRI Report for Xinjiang Shao", :align => :center, :size => 40
    end
    text "Date of Test: 2015", :align => :center, :size => 14
    
    start_new_page
    
    define_grid(:columns => 4, :rows => 5, :gutter => 0)
    count = 0
    size = 300
    files = Dir.glob("/Users/xinjiang/Documents/MRI-Xinjiang/DICOM/PA1/ST1/*/*{.jpg}")
    files.each do |f|
        if !File.directory? f then
            if count % 20 == 0 && count != 0 
                start_new_page
            end
            row = count % 4
            column = (count / 4 ).to_i % 5
            puts column.to_s + ', ' +row.to_s + ' total:' +count.to_s
            grid(column, row.to_i).bounding_box do
                #text column.to_s + ', ' +row.to_s + ' total:' +count.to_s
                stroke_bounds
                image f, :fit => [size, size], :position => :center, :scale => 0.4 
            end
            count += 1
        end
    end

end

