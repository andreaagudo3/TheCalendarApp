import Foundation
import JTAppleCalendar
import UIKit

private let preDateSelectable: Bool = true
private let todayTextColor: UIColor = .white
private let todayRoundColor: UIColor = Color.brand
private let todayFont: UIFont = Font.bodySmallBold

private let selectedRoundColor: UIColor = Color.yellowSelection
private let selectedTextColor: UIColor = .white
private let selectedFont: UIFont = Font.bodySmallBold

private let unselectableTextColor: UIColor = Color.greyTertiary
private let unselectableFont: UIFont = Font.bodySmall

private let selectableTextColor: UIColor = Color.greySecondary
private let selectableFont: UIFont = Font.bodySmallBold

class CalendarCell: JTACDayCell {
    
    @IBOutlet var selectedView: AnimationView!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet weak var dotView: UIView!
    
    var selectable = false
    var day: CalendarDay!
    
    override func awakeFromNib() {
        selectedView.cornerRadius = ViewConstants.cornerRadius
        self.dotView.layer.cornerRadius = self.dotView.bounds.height / 2
        self.dotView.layer.cornerRadius = self.dotView.bounds.height / 2
        dotView.isHidden = true
    }
    
    func handleCellSelection(cellState: CellState,
                             day: CalendarDay) {
        self.day = day
        let date = day.date
        
        self.selectable = true
        
        self.selectedView.backgroundColor = selectedRoundColor
        self.selectedView.isHidden = true
        
        if cellState.dateBelongsTo != .thisMonth {
            // Showing empty spaces for days from other months
            self.isUserInteractionEnabled = false
            self.dayLabel.text = ""
    
        } else if date.isToday {
            self.dayLabel.text = cellState.text
            self.dayLabel.textColor = todayTextColor
            self.dayLabel.font = todayFont
            self.selectedView.isHidden = false
            self.selectedView.backgroundColor = todayRoundColor
            
            self.isUserInteractionEnabled = self.selectable
        } else {
            self.isUserInteractionEnabled = self.selectable
            
            self.dayLabel.text = cellState.text
            self.dayLabel.textColor = self.selectable ? selectableTextColor : unselectableTextColor
            self.dayLabel.font = self.selectable ? selectableFont : unselectableFont
        }
        
        dotView.isHidden = !day.isHighlighted || cellState.dateBelongsTo != .thisMonth
        configueViewIntoBubbleView(cellState, date: date)
    }
    
    func cellSelectionChanged(_ cellState: CellState, date: Date) {
        if cellState.isSelected {
            if self.selectedView.isHidden || date.isToday {
                configueViewIntoBubbleView(cellState, date: date)
                self.selectedView.animateWithBounceEffect(withCompletionHandler: {
                })
            }
        } else {
            configueViewIntoBubbleView(cellState, date: date)
        }
    }
    
    fileprivate func configueViewIntoBubbleView(_ cellState: CellState, date: Date) {
        guard self.selectable else {
            return
        }
        
        if cellState.isSelected {
            self.selectedView.isHidden = cellState.dateBelongsTo != .thisMonth
            self.dayLabel.textColor = selectedTextColor
            self.dayLabel.font = selectedFont
            self.selectedView.backgroundColor = selectedRoundColor
        } else {
            if date.isToday && cellState.dateBelongsTo == .thisMonth {
                self.dayLabel.textColor = todayTextColor
                self.selectedView.isHidden = false
                self.selectedView.backgroundColor = todayRoundColor
                self.dayLabel.font = todayFont
                return
            }
            
            self.dayLabel.textColor = selectableTextColor
            self.dayLabel.font = selectableFont
            self.selectedView.isHidden = true
        }
    }
}
