function HeadDom(){
    return(
            <div className='head'>
                <div className='head_content'>
                    <h1>SSH-DEMO&nbsp;&nbsp;&nbsp;&nbsp;<small>a demo about CRUD</small></h1>
                </div>
             </div>
    );                    
}

function ContainerDom(){
    return(
            <div className='content_body'>
                <div className='content_body_content'>
                    <ToolBar/>
                    <DataGrid/>
                    <div className='row'></div>
                </div>
            </div>
    );                    
}

class ToolBar extends React.Component{
    constructor(props){
        super(props);
        this.updateEvent = this.updateEvent.bind(this);
        this.deleteEvent = this.deleteEvent.bind(this);
    }
    updateEvent(){
        alert("this is update...");
    }
    deleteEvent(){
        alert("this is del...");
    }
    render(){
        return (
                <div className='row toolStyle'>
                    <button type='button' className='btn btn-success btnStyle btn-xs'  onClick={this.updateEvent}><span className='glyphicon glyphicon-plus' aria-hidden='true'></span>新增</button>
                    <button type='button' className='btn btn-danger btn-xs' onClick={this.deleteEvent}><span className='glyphicon glyphicon-remove' aria-hidden='true'></span>删除</button>
                </div>
                );
    }
}

class DataGrid extends React.Component{
	render(){
	    return(
	            <div className='table_conent'>
    	            <table className='table table-striped'>
    	                <thead>
    	                    <tr>
    	                        <th><input type='checkbox'/></th>
    	                        <th>#</th><th>工号</th><th>姓名</th><th>性别</th><th>生日</th><th>部门</th><th>操作</th>
    	                    </tr>
    	                </thead>
    	                <tbody></tbody>
    	            </table>
	            </div>
	    );
	}
}

class PageHelper extends React.Component{
    render(){
        return (
                <div className='row bottom'>
                    <div className='bottom_content'>
                        <div id='pageinfo' className='col-xs-3 col-xs-offset-3'></div>
                        <div id='page_nav' className='col-xs-6'>
                            <nav aria-label='Page navigation'>
                                <ul id='pageUl' className='pagination'></ul>
                            </nav>              
                        </div>
                    </div>
                </div>
        );
    }
}

function App() {
    return(
            <div>
                <HeadDom/>
                <ContainerDom/>
                <PageHelper />
            </div>          
    );
}

ReactDOM.render(<App />,document.getElementById('body'));