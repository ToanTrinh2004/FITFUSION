import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Dashboard from './pages/Dashboard';
import Users from './pages/Users';
import Exercises from './pages/Exercises';
import Trainers from './pages/Trainers';

function App() {
  return (
    <Router>
      <div style={{ display: 'flex' }}>
        <Sidebar />
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/users" element={<Users />} />
          <Route path="/exercises" element={<Exercises />} />
          <Route path="/trainers" element={<Trainers />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
