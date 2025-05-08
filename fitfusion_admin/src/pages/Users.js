const Users = () => {
    const [users, setUsers] = useState([]);
  
    useEffect(() => {
      fetch("/api/admin/users")
        .then(res => res.json())
        .then(data => setUsers(data));
    }, []);
  
    return (
      <div>
        <h2>Danh sách người dùng</h2>
        <table>
          <thead>
            <tr><th>ID</th><th>Tên</th><th>Email</th></tr>
          </thead>
          <tbody>
            {users.map(user => (
              <tr key={user.id}><td>{user.id}</td><td>{user.name}</td><td>{user.email}</td></tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  };
  