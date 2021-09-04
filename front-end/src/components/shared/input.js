export default function InputText({type, value, onChangeValue, label, place_holder}) {

    return(
        <div className="text">
            <label>{label}</label>
            <input value={value} placeholder={place_holder} type={type} onChange={(e) => onChangeValue(e.target.value)} />
        </div>
    )
}