import * as React from 'react';
import blue from '@material-ui/core/colors/blue';
import { ThemeProvider, createTheme } from '@material-ui/core/styles';

const theme = createTheme({
  palette: {
    primary: blue,
    type: 'light',
  },
});

function MUITheme({ children }) {
  return <ThemeProvider theme={theme}> {children} </ThemeProvider>;
}

export default MUITheme;
