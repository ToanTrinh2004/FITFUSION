export const mockUsers = [
  {
    id: '1',
    username: 'user1',
    fullname: 'Nguyễn Văn A',
    mycoach: 'Trần Văn C'
  },
  {
    id: '2',
    username: 'user2',
    fullname: 'Lê Thị B',
    mycoach: 'Trần Văn C'
  },
  {
    id: '3',
    username: 'user3',
    fullname: 'Phạm Văn D',
    mycoach: 'Ngô Thị E'
  },
  {
    id: '4',
    username: 'user4',
    fullname: 'Hoàng Văn F',
    mycoach: null
  },
  {
    id: '5',
    username: 'user5',
    fullname: 'Đỗ Thị G',
    mycoach: 'Ngô Thị E'
  }
];

export const mockCoaches = [
  {
    id: '1',
    username: 'coach1',
    fullname: 'Trần Văn C',
    mystudents: ['Nguyễn Văn A', 'Lê Thị B']
  },
  {
    id: '2',
    username: 'coach2',
    fullname: 'Ngô Thị E',
    mystudents: ['Phạm Văn D', 'Đỗ Thị G']
  },
  {
    id: '3',
    username: 'coach3',
    fullname: 'Vũ Văn H',
    mystudents: []
  }
];

export const mockContracts = [
  {
    id: '1',
    coachName: 'Trần Văn C',
    userName: 'Nguyễn Văn A',
    trainingType: 'Yoga',
    trainingDuration: '3 tháng',
    contractEndDate: '2025-08-15',
    contractValue: '5,000,000 VND'
  },
  {
    id: '2',
    coachName: 'Trần Văn C',
    userName: 'Lê Thị B',
    trainingType: 'Gym cá nhân',
    trainingDuration: '6 tháng',
    contractEndDate: '2025-11-20',
    contractValue: '12,000,000 VND'
  },
  {
    id: '3',
    coachName: 'Ngô Thị E',
    userName: 'Phạm Văn D',
    trainingType: 'Boxing',
    trainingDuration: '2 tháng',
    contractEndDate: '2025-07-05',
    contractValue: '4,500,000 VND'
  },
  {
    id: '4',
    coachName: 'Ngô Thị E',
    userName: 'Đỗ Thị G',
    trainingType: 'Pilates',
    trainingDuration: '4 tháng',
    contractEndDate: '2025-09-30',
    contractValue: '7,200,000 VND'
  }
];