import React from 'react';
import { Card, CardContent, Typography, Button, Chip } from '@mui/material';

const OrderCard = ({ order = {} }) => {
  return (
    <Card sx={{ maxWidth: 350, m: 2, p: 2, boxShadow: 3, borderRadius: 2 }}>
      <CardContent>
        <Typography variant="h6" gutterBottom>
          {order.customerName || 'שם לקוח לא ידוע'}
        </Typography>

        <Typography variant="body2" color="text.secondary">
          סרט: {order.movieTitle || 'לא צוין שם הסרט'}
        </Typography>

        <Typography variant="body2" color="text.secondary">
          תאריך הזמנה: {order.orderDate || 'לא צוין תאריך'}
        </Typography>

        <Chip
          label={order.paymentStatus === 'Paid' ? 'שולם' : 'לא שולם'}
          color={order.paymentStatus === 'Paid' ? 'success' : 'error'}
          sx={{ mt: 1 }}
        />

        <Button variant="contained" color="primary" fullWidth sx={{ mt: 2 }}>
          צפייה בפרטים
        </Button>
      </CardContent>
    </Card>
  );
};

export default OrderCard;
