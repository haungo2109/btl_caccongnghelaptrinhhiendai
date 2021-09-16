import './input.css'

export default function InputText({type, value, onChangeValue, label, place_holder}) {

    return(
        <div className="input-text">
            {label && <label>{label}</label>}
            <input value={value} placeholder={place_holder} type={type} onChange={onChangeValue} />
        </div>
    )
}