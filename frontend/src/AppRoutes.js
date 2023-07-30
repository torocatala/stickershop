import { Routes, Route } from 'react-router-dom';
import HelloName from './HelloName'; 
import App from './App';

function AppRoutes() {
  return (
      <Routes>
        <Route path="/" element={<App />} />
        <Route path="/hello" element={<HelloName />} />
      </Routes>
  );
}

export default AppRoutes;
