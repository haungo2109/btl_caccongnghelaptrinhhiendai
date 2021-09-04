import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import './button.css'

export default function Button({name, onClick, icon, type}) {

    return(
        <div className={`button ${type? type: ''}`} onClick={onClick}>
            {icon && <FontAwesomeIcon icon={icon} />}
            <p>{name}</p>
        </div>
    )
}