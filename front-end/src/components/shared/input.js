import './input.css'
import './shared.css'

export default function InputText({type, value, onChangeValue, label, place_holder}) {

    return(
        <div className="input-text shared-input">
            {label && <label>{label}</label>}
            <input value={value} placeholder={place_holder} type={type} onChange={onChangeValue} />
        </div>
    )
}