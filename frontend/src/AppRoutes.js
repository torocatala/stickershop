import { Routes, Route } from 'react-router-dom';
import HelloName from './HelloName';
import ProductList from './Products';
import App from './App';

function AppRoutes() {
  return (
      <Routes>
        <Route path="/" element={<App />} />
        <Route path="/hello" element={<HelloName />} />
        <Route path="/products" element={<ProductList />} />
      </Routes>
  );
}

export default AppRoutes;
