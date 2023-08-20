import logo from './logo.svg';
import './App.css';
import { Link } from 'react-router-dom';
import { useState, useCallback } from 'react'
import ProductList from './Products';
import ProductsListGraphql from './ProductsGraphql';

function App() {

  const [showProducts, setShowProducts] = useState('Show');
  const [showGraphqlProducts, setShowGraphqlProducts] = useState('Show');
  const toggleGallery = useCallback((currentState, graphql) => {
    let state = currentState === 'Show' ? 'Hide' : 'Show';
    if(graphql){
      setShowGraphqlProducts(state)
    }else{
      setShowProducts(state)
    }
  });

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
        <Link to="/">Go Home</Link>
        <Link to="/hello">Go to HelloName page</Link>
        <Link to="/products">Products</Link>
        <Link to="/productsgraphql">Products Graphql</Link>
        <button onClick={() => toggleGallery(showProducts, false)}>{ showProducts } products</button>
        <button onClick={() => toggleGallery(showGraphqlProducts, true)}>{ showGraphqlProducts } graphql products</button>
      </header>
      {showProducts === 'Hide' && (
        <ProductList />
      )}
      {showGraphqlProducts  === 'Hide' && (
        <ProductsListGraphql />
      )}

    </div>
  );
}

export default App;
