import { useEffect, useState } from 'react'
import Select from 'react-select';
import './selectsList.css'
import './shared.css'

export default function SelectInput({options, onSelect, selectedOption, valueKey="id", labelKey="name", label}) {
    
    const [selected, setSelected] = useState(null);

    useEffect(() => {
        if(selectedOption) {
            let s = options.filter(o => o.id === selectedOption);
            setSelected(s);
        } else {
            setSelected(options[0]);
        }
    }, [options, selectedOption])

    return (
        <div className="shared-input selects-input">
            {label && <label>{label}</label>}
            <Select options={options} onChange={onSelect} value={selected} getOptionLabel={(opt) => opt[labelKey]} getOptionValue={(opt) => opt[valueKey]} />
        </div>
    )
}