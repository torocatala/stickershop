import { useState } from 'react';
import axios from 'axios';

function HelloName() {

  const [name, setName] = useState("");
  const [message, setMessage] = useState("");

  const getHelloMessage = async () => {
    try {
      const response = await axios.get(`http://localhost:3001/hello/${name}`);
      setMessage(response.data.msg);
    } catch (error) {
      console.error(`Error: ${error}`);
    }
  };

  return (
    <div className="containter text-center">
      <header className="App-header">
        <div className="row">
          <div className="col-12">
            <div className="input-group mb-3">
                <span className="input-group-text">Your name</span>
                <input type="text" className="form-control" aria-label="Your name" value={name} onChange={e => setName(e.target.value)} />
            </div>
          </div>
          <div className="col-12">
            <button className="btn btn-primary" onClick={getHelloMessage}>
                Get Hello Message
            </button>
          </div>
          <div className="col-12">
            <h1 className="display-1">{message}</h1>
          </div>
        </div>
      </header>
    </div>
  );
}

export default HelloName;
