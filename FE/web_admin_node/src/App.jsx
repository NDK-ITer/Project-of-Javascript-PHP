import { useContext, useEffect } from 'react';
import { GetAllRole } from './apis/services/AuthService';
import './assets/app.css';
import { ToastContainer, toast } from "react-toastify";
import { RoleContext } from './contexts/RoleContext';

function App() {
  const {UpdateRole} = useContext(RoleContext)
  const getRole = async() =>{
    try {
      const res = await GetAllRole()
      if(res.state === 1) {
        UpdateRole(res.data)
      }

    } catch (error) {
      toast.error(error);
    }
  }
  useEffect(() => {
    getRole()
  },[])
  return (<>
    <div className="App">
      hello world
    </div>
    <ToastContainer />
  </>);
}

export default App;
