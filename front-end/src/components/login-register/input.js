import './input.css'

export function Input(props) {

    const handleChange = (data) => {
        props.changeData(data.target.value)
    }

    return(
        <div className="input">
            <label>
                {props.name}
            </label>
            <input type={props.type} value={props.value} onChange={handleChange} name="name" />
        </div>
    )
}