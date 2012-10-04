class AssetLoss < ActiveRecord::Base
  # relationships, variables, lists, relationship checking
  
  belongs_to :location
  belongs_to :asset
  belongs_to :handled_by,       :class_name => 'Staff', :foreign_key => 'last_handled_by' 
  belongs_to :enforced_by,      :class_name => 'Staff', :foreign_key => 'prev_action_enforced_by'
  belongs_to :investigator,     :class_name => 'Staff', :foreign_key => 'investigated_by'
  belongs_to :sec_officer,      :class_name => 'Staff', :foreign_key => 'security_officer_id'
  belongs_to :hod,              :class_name => 'Staff', :foreign_key => 'endorsed_hod_by'
  
  
  
  def item_name
    if loss_type == 'Asset'
      asset.code_asset
    elsif loss_type == 'Cash'
      asset.cash_type
    elsif loss_type == 'Supplies'
      "Some Stationery"
    else
    end
  end
  
  
  
  MONEY = [
        #  Displayed       stored in db
        [ "Tunai",        "Tunai" ],
        [ "Cek",          "Cek" ],
        [ "Wang Pos",     "Wang Pos" ],
        [ "Kiriman Wang", "Kiriman Wang" ],
        [ "Lain-Lain",    "Lain-Lain" ]
        
  ]
  
  
  
  def location_details 
      if location.blank?
        "Not Registered"
      elsif location_id?
        location.location_list
      else 
        "Location has been removed"
      end
  end
  
  def hod_details 
      if hod.blank?
        "Not Registered"
      elsif endorsed_hod_by?
        hod.staff_name_with_position
      else 
      end
  end
  
  def asset_details         
      if asset.blank?
        "None Assigned"
      elsif asset_id?
        asset.code_asset
      else 
        "None Assigned"
      end
  end
  
end
