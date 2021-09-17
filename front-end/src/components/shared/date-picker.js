import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import './date-picker.css'
import './shared.css'

export default function DatePickerInput({selected, onChange, label}) {
    return (
        <div className="shared-input date-input">
            {label && <label>{label}</label>}
            <DatePicker onChange={onChange} selected={selected} />
        </div>
    )
}