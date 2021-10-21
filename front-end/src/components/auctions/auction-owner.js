import auctionApi from '../../api/auctionApi';
import AuctionList from './auction-list'
import './auction-owner.css'

export default function AuctionOwner({handleLike, handleDelete}) {

    const [auctions, setAuctions] = useState([]);
    const [init, setInit] = useState(false);
    const [page, setPage] = useState(1);
    const [totalPage, setTotalPage] = useState(1);
    const [loading, setLoading] = useState(true);
    let query = useQuery();
    let store = useStore();
    let user = store.getState();
    let {path, url} = useRouteMatch();
    let history = useHistory();

    useEffect( () => {
        
    }, [])

    useEffect(() => {
        if(query.get('page')) {
            setPage(query.get('page'))
        } else {
            handleGetListByPage(page);
        }
        setInit(true);
    }, [])

    useEffect(() => {
        if(init) {
            handleGetListByPage(page);
        }
    }, [page])

    let navigate = (path) => {
        history.push(`${url}${path}`)
    }

    let handleGetListByPage = (p, scroll = true) => {
        if(scroll) {
            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });
        }
        
        setLoading(true);
        auctionApi.getAuctionOwner(p).then(data => {
            // console.log(data.results)
            setAuctions(data.results);
            setLoading(false);
            if(data.count) {
                setTotalPage(Math.round(data.count / postPerPage));
            }
        })
    }
    let handleClickPagination = (pageNum) => {
        setPage(pageNum);
        // console.log(pageNum)
        history.push(`/auctions/owner?page=${pageNum}`);
    }

    return(
        <AuctionList auctions={auctions} handlePagination={handleClickPagination} handleLike={handleLike} handleDelete={handleDelete}
            url={url} page={page} totalPage={totalPage} >
        </AuctionList>
    )
}