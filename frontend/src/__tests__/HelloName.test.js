import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import HelloName from '../HelloName';
import { MemoryRouter } from 'react-router-dom';
import axios from 'axios';

jest.mock('axios');

describe('HelloName component', () => {
  test('renders input and button', () => {
    axios.get.mockResolvedValue({ data: { msg: 'Hello John' }});

    render(
      <MemoryRouter>
        <HelloName />
      </MemoryRouter>
    );

    const inputElement = screen.getByLabelText('Your name');
    const buttonElement = screen.getByRole('button', { name: /get hello message/i });
    
    expect(inputElement).toBeInTheDocument();
    expect(buttonElement).toBeInTheDocument();
  });
  
  test('displays hello message on button click', async () => {
    axios.get.mockResolvedValue({ data: { msg: 'Hello John' }});
    render(<HelloName />);
    
    const inputElement = screen.getByLabelText('Your name');
    const buttonElement = screen.getByRole('button', { name: /get hello message/i });

    fireEvent.change(inputElement, { target: { value: 'John' } });
    fireEvent.click(buttonElement);

    await waitFor(() => {
      const messageElement = screen.getByRole('heading', { level: 1 });
      expect(messageElement).toHaveTextContent('Hello John');
    });
  });
});
