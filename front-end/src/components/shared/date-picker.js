import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import './date-picker.css'

export default function DatePickerInput({selected, onChange}) {
    return (
        <div>
            <DatePicker onChange={onChange} selected={selected} />
        </div>
    )
}