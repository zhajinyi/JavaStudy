function HeadDom() {
    return (
        <div className='head'>
            <div className='head_content'>
                <h1>SSH-DEMO&nbsp;&nbsp;&nbsp;&nbsp;<small>a demo about CRUD</small></h1>
            </div>
        </div>
    );
}

function ContainerDom() {
    return (
        <div className='content_body'>
            <div className='content_body_content'>
                <ToolBar />
                <DataGrid />
                <PageHelper/> 
            </div> 
        </div>
    );
}

class ToolBar extends React.Component {
    constructor( props ) {
        super( props );
        this.updateEvent = this.updateEvent.bind( this );
        this.deleteEvent = this.deleteEvent.bind( this );
    }
    updateEvent() {
        alert( "this is update..." );
    }
    deleteEvent() {
        alert( "this is del..." );
    }
    render() {
        return (
            <div className='row toolStyle'>
                <button type='button' className='btn btn-success btnStyle btn-xs' onClick={this.updateEvent}><span className='glyphicon glyphicon-plus' aria-hidden='true'></span>新增</button>
                <button type='button' className='btn btn-danger btn-xs' onClick={this.deleteEvent}><span className='glyphicon glyphicon-remove' aria-hidden='true'></span>删除</button>
            </div>
        );
    }
}

class DataGrid extends React.Component {
    render() {
        return (
            <div className='table_conent'>
                <table className='table table-bordered table-hover'>
                    <thead>
                        <tr>
                            <th><input type='checkbox' /></th>
                            <th>Id</th><th>姓名</th><th>性别</th><th>生日</th><th>邮箱</th><th>部门</th><th>操作</th>
                        </tr>
                    </thead>
                    <DataTbody/>
                </table>
            </div>
        );
    }
}
var dataRequestUrl = "getEmps.action";
class DataTbody extends React.Component {
    constructor( props ) {
        super( props );
        this.state = {
            data: [],
            load: false
        }
        this.fetchData = this.fetchData.bind( this );
    }

    componentDidMount() {
        this.fetchData();
    }

    fetchData() {
        fetch( dataRequestUrl+"?pn=2")  
        .then( response => response.json() )
        .then( responseData => {
            // 注意，这里使用了this关键字，为了保证this在调用时仍然指向当前组件，我们需要对其进行“绑定”操作
            this.setState( {
                data: responseData.list,
                loaded: true
            } );
        } );
    }
    render() {
        if (!this.state.loaded) {
          return this.renderLoadingView();
        }

        return (<TrList listData={this.state.data}/>);
      }   
        renderLoadingView() {
            return (
                    <tbody>
                        <tr className="loadingTr">
                            <td colSpan='8'><h1>Loading ...</h1></td>
                            </tr>    
                    </tbody>
                        
            );
          }  
}
function TrList(props){
    var llistData = props.listData;
    var listItems = llistData.map(
            (obj) => <tr key={obj.id.toString()}><td><input type='checkbox' /></td><td>{obj.id}</td><td>{obj.name}</td><td>{obj.sex==0?'男':'女'}</td><td>{obj.birthDate}</td><td>{obj.eMail}</td><td>{obj.department.name}</td><td><MultiBtn empId={obj.id}/></td></tr>
    );
    return (
            <tbody>
                {listItems}
            </tbody>
          );
}
            
function MultiBtn(props){
    return (
            <div>
                <button type='button' className='btn btn-success btn-sm edit_btn btn-xs'  data-editid={props.empId}><span className='glyphicon glyphicon-pencil' aria-hidden='true'></span>修改</button>&nbsp;&nbsp;
                <button type='button' className='btn btn-danger btn-sm delete_btn btn-xs' data-deleteid={props.empId}><span className='glyphicon glyphicon-trash' aria-hidden='true'></span>删除</button>
            </div>
    );
}
class PageHelper extends React.Component {
    render() {
        return (
                <div className='bottom_content'>
                    <div id='pageinfo'></div>
                    <div id='page_nav'>
                        <nav aria-label='Page navigation'>
                            <ul id='pageUl' className='pagination'></ul>
                        </nav>
                    </div>
                </div>
        );
    }
}

function App() {
    return (
        <div>
            <HeadDom />
            <ContainerDom />
            <PageHelper />
        </div>
    );
}

ReactDOM.render( <App />, document.getElementById( 'body' ) );