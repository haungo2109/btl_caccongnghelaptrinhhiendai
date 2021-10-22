import './report-dialog.css'
import Dialog from '@mui/material/Dialog';
import { Button, DialogActions, DialogTitle, FormControl, InputLabel, MenuItem, Select } from '@mui/material';
import { useState } from 'react/cjs/react.development'
import InputText from './input';

export default function ReportDialog({state, handleClose, listType = []}) {

    const [content, setContent] = useState('');
    const [type, setType] = useState(1);

    let handleCloseDialog = (action = "cancel") => {
        handleClose({'content': content, 'type': type, 'action': action});
        setContent('');
        setType(1);
    }

    return(
        <div className="dialog">
            <Dialog open={state} onClose={() => handleCloseDialog('cancel')} >
                <DialogTitle>Vui lòng nhập vào nội dung báo cáo</DialogTitle>
                <div className="select-text">
                    <FormControl fullWidth >
                        <label className="label-report">Loại báo cáo </label>
                        {/* <InputLabel id="type-selector-label">Loại báo cáo</InputLabel> */}
                        <Select
                            labelId="type-selector-label" id="type-selector" value={type} onChange={(e) => setType(e.target.value)} >
                            {listType.length != 0 && listType.map(t => {
                                return(
                                    <MenuItem key={t.id} value={t.id}>{t.name}</MenuItem>
                                )
                            })}
                        </Select>
                    </FormControl>
                </div>
                <div className="input-text-dialog">
                    <InputText type={"text"} value={content} onChangeValue={(e) => setContent(e.target.value)} label={"Nội dung"} />                
                </div>
                <DialogActions>
                    <Button onClick={() => handleCloseDialog('cancel')}>Hủy</Button>
                    <Button onClick={() => handleCloseDialog('confirm')}>Xác nhận</Button>
                </DialogActions>
            </Dialog>
        </div>
    )
}