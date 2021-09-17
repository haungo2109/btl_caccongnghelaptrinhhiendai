import './pagination.css'

export function PaginationItem({text, onClick, className=""}) {
    return(
        <div className={"pagination-item " + className} onClick={onClick} >
            <p>{text}</p>
        </div>
    )
}

export default function Pagination({count, onClick, currentPage}) {

    return(
        <div className="pagination-container">
            <div className="outer-line">
                {/* {currentPage - 1 > 0 && <PaginationItem text="Trước" onClick={() => onClick(currentPage-1)} />} */}
                {currentPage - 2 > 0 && <PaginationItem text={currentPage - 2} onClick={() => onClick(currentPage-2)} />}
                {currentPage - 1 > 0 && <PaginationItem text={currentPage - 1} onClick={() => onClick(currentPage-1)} />}
                <PaginationItem text={currentPage} className="current-page" />
                {currentPage < count && <PaginationItem text={currentPage + 1} onClick={() => onClick(currentPage+1)}  />}
                {currentPage + 1 < count && <PaginationItem text={currentPage + 2} onClick={() => onClick(currentPage+2)} />}
                {/* {currentPage < count && <PaginationItem text="Sau" onClick={() => onClick(currentPage+1)} />} */}
            </div>
        </div>
    )
}