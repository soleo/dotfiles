# CONVERT DICOM IMAGES TO JPG
# Needs Imagemagick, plus the Rmagic and Dicom gems:
#$ gem install rmagick
#$ gem install dicom
#$ gem install prawn
#$ gem install fastimage
require 'prawn'
require 'dicom'
require 'fastimage'
include DICOM
# Change the log level so that only error messages are displayed:
DICOM.logger.level = Logger::ERROR
# Setting up a simple file log:
l = Logger.new('my_logfile.log')
DICOM.logger = l
info = {
 :Title => "Xinjiang's Brain MRI T2",
 :Author => "Xinjiang Shao",
 :Subject => "MRI Scan",
 :Keywords => "MRI PDF",
 :Creator => "Xinjiang",
 :Producer => "Prawn",
 :CreationDate => Time.now
}

patients_name = ""
patient_id = ""
patients_birth_date = ""
patients_sex = ""
mr_acquisition_type = ""
imaging_frequency = ""
magnetic_field_strength = ""
photometric_interpretation = ""
acquisition_date = ""

files = Dir.glob("/Users/xinjiang/Documents/MRI-Xinjiang/DICOM/PA1/ST1/*/*")
puts files.length
files.each do |f|
    if !File.directory? f then
        dcm = DObject.read(f)
        if dcm.read?
            #dcm.print
            patients_name = dcm.patients_name.value
            patient_id = dcm.patient_id.value
            patients_birth_date = dcm.patients_birth_date.value
            patients_sex = dcm.patients_sex.value
            mr_acquisition_type = dcm.mr_acquisition_type.value
            imaging_frequency = dcm.imaging_frequency.value
            magnetic_field_strength = dcm.magnetic_field_strength.value
            photometric_interpretation = dcm.photometric_interpretation.value
            acquisition_date = dcm.acquisition_date.value
            # 58 0010,0010     Patient's Name                               PN     14 shao xin jiang
             # 59 0010,0020     Patient ID                                   LO      8 2215417
             # 60 0010,0030     Patient's Birth Date                         DA      8 19880406
             # 61 0010,0040     Patient's Sex                                CS      2 M
             # 62 0010,1000     Other Patient IDs                            LO      0
             # 63 0010,1010     Patient's Age                                AS      4 026Y

             # 70 0018,0020     Scanning Sequence                            CS      2 IR
             # 71 0018,0021     Sequence Variant                             CS      4 NONE
             # 72 0018,0022     Scan Options                                 CS     70 FC_FREQ_AX_GEMS\FC\SAT_GEMS\VB_GEMS\SEQ_GEMS\TRF_GEMS\FILTERED_GEMS\SP
             # 73 0018,0023     MR Acquisition Type                          CS      2 2D
             # 74 0018,0025     Angio Flag                                   CS      2 N
             # 75 0018,0050     Slice Thickness                              DS      2 6
             # 76 0018,0080     Repetition Time                              DS      8 2592.08
             # 77 0018,0081     Echo Time                                    DS      6 11.048
             # 78 0018,0082     Inversion Time                               DS      4 750
             # 79 0018,0083     Number of Averages                           DS      2 1
             # 80 0018,0084     Imaging Frequency                            DS     10 63.862735
             # 81 0018,0085     Imaged Nucleus                               SH      2 1H
             # 82 0018,0086     Echo Number(s)                               IS      2 1
             # 83 0018,0087     Magnetic Field Strength                      DS      4 1.5
            # 0028,0004     Photometric Interpretation
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
    
    files = Dir.glob("/Users/xinjiang/Documents/MRI-Xinjiang/DICOM/PA1/ST1/SE" + number.to_s + "/*{.jpg}")
    files.each do |f|
        if !File.directory? f then
            image_list2.read f
        end
    end
    newImage = image_list2.append true
    newImage.write "SE" + number.to_s + ".jpg"
end


Prawn::Document.generate("Xinjiang-MRI-Report.pdf", :info => info) do
    move_down 150
    font("Courier") do
        text "MRI Report", :align => :center, :size => 40
    end
    move_down 250
    text "Patient's Name: " + patients_name, :align => :right, :size => 12
    move_down 12
    text "Patient ID: " + patient_id, :align => :right, :size => 12
    move_down 12
    text "Patient Birth Date: " + patients_birth_date, :align => :right, :size => 12
    move_down 12
    text "Patient's Sex: " + patients_sex, :align => :right, :size => 12
    move_down 12
    text "MR Acquisition Type: " + mr_acquisition_type, :align => :right, :size => 12
    move_down 12
    text "Imaging Frequency: " + imaging_frequency, :align => :right, :size => 12
    move_down 12
    text "Magnetic Field Strength: " + magnetic_field_strength, :align => :right, :size => 12
    move_down 12
    text "Photometric Interpretation: " + photometric_interpretation, :align => :right, :size => 12
    move_down 12
    text "Acquisition Date: " + acquisition_date, :align => :right, :size => 12
    
    start_new_page

    
    define_grid(:columns => 4, :rows => 5, :gutter => 0)
    count = 0
    size = 140
    files = Dir.glob("/Users/xinjiang/Documents/MRI-Xinjiang/DICOM/PA1/ST1/*/*{.jpg}")
    files.each do |f|
        if !File.directory? f then
            if count % 20 == 0 && count != 0 
                start_new_page
            end
            row = count % 4
            column = (count / 4 ).to_i % 5
            #puts column.to_s + ', ' +row.to_s + ' total:' +count.to_s
            grid(column, row.to_i).bounding_box do
                #text column.to_s + ', ' +row.to_s + ' total:' +count.to_s
                #stroke_bounds
                width, height = FastImage.size(f)
                if width > size
                    image f, :fit => [size, size], :position => :center
                else
                    image f, :position => :center
                end
            end
            count += 1
        end
    end

end

