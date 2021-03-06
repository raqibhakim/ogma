class Staff < ActiveRecord::Base
  
  paginates_per 13
  
  has_one           :position
  has_many          :tenants
  
  
  has_attached_file :photo,
                    :url => "/assets/staffs/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/staffs/:id/:style/:basename.:extension"#, :styles => {:thumb => "40x60"}
                    
  has_many          :qualifications, :dependent => :destroy
  accepts_nested_attributes_for :qualifications, :allow_destroy => true, :reject_if => lambda { |a| a[:level_id].blank? }
  
  has_many          :loans, :dependent => :destroy
  accepts_nested_attributes_for :loans, :reject_if => lambda { |a| a[:ltype].blank? }
  
  has_many          :bankaccounts, :dependent => :destroy
  accepts_nested_attributes_for :bankaccounts, :reject_if => lambda { |a| a[:account_no].blank? }
  
  has_many          :kins, :dependent => :destroy
  accepts_nested_attributes_for :kins, :reject_if => lambda { |a| a[:kintype_id].blank? }
  
  
  belongs_to        :title,       :class_name => 'Title',       :foreign_key => 'titlecd_id'
  belongs_to        :staffgrade, :class_name => 'Employgrade',  :foreign_key => 'staffgrade_id'
  
  
  #validates_attachment_size         :photo, :less_than => 500.kilobytes
  #validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
 #---------------Validations------------------------------------------------
 validates :icno, presence: true, numericality: true, length: { is: 12 }, uniqueness: true
  #validates_numericality_of :icno#, :kwspcode
  #validates_length_of       :icno, :is =>12
  validates_presence_of     :name, :coemail, :code, :appointdt #appointment date must exist be4 can apply leave
  validates_uniqueness_of   :fileno, :coemail, :code
  #validates_format_of       :name, :with => /^[a-zA-Z'`\/\.\@\ ]+$/, :message => I18n.t('activerecord.errors.messages.illegal_char') #add allowed chars between bracket
  validates_presence_of     :cobirthdt, :addr, :poskod_id, :staffgrade_id, :statecd, :country_cd, :fileno
  #validates_length_of      :cooftelno, :is =>10
  #validates_length_of      :cooftelext, :is =>5
  validates_length_of       :addr, :within => 1..180,:too_long => "Address Too Long"
  validate :coemail, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => I18n.t('activerecord.errors.messages.invalid') }
                               
  

  
  #--------------------Declerations----------------------------------------------------
    def age
      Date.today.year - cobirthdt.year unless cobirthdt == nil
    end
 
    def formatted_mykad
      "#{icno[0,6]}-#{icno[6,2]}-#{icno[-4,4]}"
    end
    
    def mykad_with_staff_name
      "#{formatted_mykad}  #{name}"
    end  
    

end

# == Schema Information
#
# Table name: staffs
#
#  addr                    :string(255)
#  appointby               :string(255)
#  appointdt               :date
#  appointstatus           :string(255)
#  att_colour              :integer
#  bank                    :string(255)
#  bankaccno               :string(255)
#  bankacctype             :string(255)
#  birthcertno             :string(255)
#  bloodtype               :string(255)
#  cobirthdt               :date
#  code                    :string(255)
#  coemail                 :string(255)
#  confirmdt               :date
#  cooftelext              :string(255)
#  cooftelno               :string(255)
#  country_cd              :integer
#  country_id              :integer
#  created_at              :datetime
#  employscheme            :string(255)
#  employstatus            :integer
#  fileno                  :string(255)
#  gender                  :integer
#  icno                    :string(255)
#  id                      :integer          not null, primary key
#  kwspcode                :string(255)
#  mrtlstatuscd            :integer
#  name                    :string(255)
#  pension_confirm_date    :date
#  pensiondt               :date
#  pensionstat             :string(255)
#  phonecell               :string(255)
#  phonehome               :string(255)
#  photo_content_type      :string(255)
#  photo_file_name         :string(255)
#  photo_file_size         :integer
#  photo_updated_at        :datetime
#  posconfirmdate          :date
#  position_old            :integer
#  poskod_id               :integer
#  promotion_date          :date
#  race                    :integer
#  reconfirmation_date     :date
#  religion                :integer
#  schemedt                :date
#  staff_shift_id          :integer
#  staffgrade_id           :integer
#  starting_salary         :decimal(, )
#  statecd                 :integer
#  svchead                 :string(255)
#  svctype                 :string(255)
#  taxcode                 :string(255)
#  thumb_id                :integer
#  time_group_id           :integer
#  titlecd_id              :integer
#  to_current_grade_date   :date
#  transportclass_id       :string(255)
#  uniformstat             :string(255)
#  updated_at              :datetime
#  wealth_decleration_date :date
#
