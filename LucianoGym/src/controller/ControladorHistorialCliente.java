/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.awt.Color;
import java.awt.Desktop;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import model.Cliente;
import model.ClienteDAO;
import model.ClienteHistorial;
import view.newprincipal;

/**
 *
 * @author User
 */
public class ControladorHistorialCliente implements MouseListener,ActionListener {

    newprincipal np;
    Cliente cl = new Cliente();
    ClienteDAO clda = new ClienteDAO();

    public ControladorHistorialCliente(newprincipal np) {
        this.np = np;
        np.tblHistorial.addMouseListener(this);
        np.tbHistoriaCliente.addMouseListener(this);
        np.btnDescargarPDF.addActionListener(this);

    }

    @Override
    public void mouseClicked(MouseEvent e) {
        JTable tblClick = (JTable) e.getSource();
        if (tblClick == np.tblHistorial) {
            if (e.getButton() == MouseEvent.BUTTON1 && e.getClickCount() == 1) {

                np.txtHistorialCliente.setText("");
                np.txtHistorialDni.setText("");
                np.txtHistorialTelefono.setText("");
                np.panelEstadoEnHistorial.setBackground(new Color(240,240,240));

                int fila = np.tblHistorial.rowAtPoint(e.getPoint());
                int columna = np.tblHistorial.columnAtPoint(e.getPoint());
                if ((fila > -1) && (columna > -1)) {
                    cl.setCodigo(Integer.parseInt(np.tblHistorial.getValueAt(fila, 0).toString()));
                    String nombre = np.tblHistorial.getValueAt(fila, 1).toString();
                    String apellidos = np.tblHistorial.getValueAt(fila, 2).toString();

                    np.txtHistorialCliente.setText(nombre + " " + apellidos);

                    np.txtcodHistorial.setText(String.valueOf(cl.getCodigo()));
                    clda.HistorialClienteCodigo(cl.getCodigo(), np.txtHistorialDni, np.txtHistorialTelefono);

                    clda.mostrarFotoCliente(np.lblFotoClienteHistorial, cl.getCodigo());
                    clda.ListarHistorialesCliente(cl.getCodigo(), np.tbHistoriaCliente, np.lblNMatriculasHist);
                    clda.SumaMembresiasHistorial(cl.getCodigo(), np.lblTotalHistorialCliente);
                    np.txtMembreHistorial.setText("");
                    np.txtPagadoHistorial.setText("");

                }
            }
        }
        if (tblClick == np.tbHistoriaCliente) {
            if (e.getButton() == MouseEvent.BUTTON1 && e.getClickCount() == 1) {

                int fila = np.tbHistoriaCliente.rowAtPoint(e.getPoint());
                int columna = np.tbHistoriaCliente.columnAtPoint(e.getPoint());
                if ((fila > -1) && (columna > -1)) {
                    cl.setCodigo(Integer.parseInt(np.tbHistoriaCliente.getValueAt(fila, 0).toString()));
                    clda.ListarPagosDelHistorial(cl.getCodigo(), np.txtMembreHistorial, np.txtPagadoHistorial);
                    String membre = np.txtMembreHistorial.getText();
                    String pagado = np.txtPagadoHistorial.getText();
              

                    if (membre.equals(pagado)) {
                        np.panelEstadoEnHistorial.setBackground(Color.GREEN);
                        np.lblEstadoEnHistorial.setText("PAGADO");
                    } else {
                        np.panelEstadoEnHistorial.setBackground(Color.RED);
                        np.lblEstadoEnHistorial.setText("CON DEUDA");
                    }
                }
            }
        }
    }

    @Override
    public void mousePressed(MouseEvent e) {

    }

    @Override
    public void mouseReleased(MouseEvent e) {

    }

    @Override
    public void mouseEntered(MouseEvent e) {

    }

    @Override
    public void mouseExited(MouseEvent e) {

    }

    @Override
    public void actionPerformed(ActionEvent e) {
        JButton source= (JButton) e.getSource();
         if (source == np.btnDescargarPDF) {
        int filaSeleccionada = np.tblHistorial.getSelectedRow();
        if (filaSeleccionada != -1) {
            generarPDF();
        } else {
            JOptionPane.showMessageDialog(null,"Seleccione un registro", "Reporte",JOptionPane.WARNING_MESSAGE);
        }
    }
    }
    private void generarPDF() {
        try {
            ClienteDAO dao = new ClienteDAO();
            int cod = Integer.parseInt(np.txtcodHistorial.getText());
            List<ClienteHistorial> clientes = dao.obtenerClientesDesdeBaseDeDatos(cod);

            FileOutputStream archivo;
            File file = new File("C:/Users/User/Desktop/LucianoGym/LucianoGym/src/pdf/membresia.pdf");
            archivo = new FileOutputStream(file);
            Document doc = new Document();
            PdfWriter.getInstance(doc, archivo);
            doc.open();

            // Contenido del PDF
            Image img = Image.getInstance("C:/Users/User/Desktop/LucianoGym/LucianoGym/src/icons/lucianogymlogo200.png");

            Paragraph fecha = new Paragraph();
            Font negrita = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD, BaseColor.BLUE);
             Font cabecera = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD, BaseColor.BLACK);

            fecha.add(Chunk.NEWLINE);
            Date date = new Date();
            fecha.add("Fecha: " + new SimpleDateFormat("dd-MM-yyyy").format(date) + "\n\n");

            PdfPTable encabezado = new PdfPTable(4);
            encabezado.setWidthPercentage(100);
            encabezado.getDefaultCell().setBorder(0);
            float[] columnasEncabezado = new float[]{20f, 30f, 70f, 40f};
            encabezado.setWidths(columnasEncabezado);
            encabezado.setHorizontalAlignment(Element.ALIGN_LEFT);

            encabezado.addCell(img);

            String ruc = "1324512233";
            String nom = "Juan Carlos Hilarez Zevallos";
            String tel = "983212123";
            String dir = "Ventanilla";
            String ra = "Luciano Gym";

            encabezado.addCell("");
            encabezado.addCell("RUC: " + ruc + "\nNombre: " + nom + "\nTeléfono: " + tel + "\nDirección: " + dir + "\nRazón: " + ra);
            encabezado.addCell(fecha);
            doc.add(encabezado);

            Paragraph cli = new Paragraph();
            cli.add(Chunk.NEWLINE);
            cli.add("Datos del cliente: " + "\n\n");
            doc.add(cli);

            PdfPTable tablacli = new PdfPTable(4);
            tablacli.setWidthPercentage(100);
            tablacli.getDefaultCell().setBorder(0);
            float[] columnaCli = new float[]{20f, 50f, 60f, 40f};
            tablacli.setWidths(columnaCli);
            tablacli.setHorizontalAlignment(Element.ALIGN_LEFT);
            PdfPCell cl1 = new PdfPCell(new Phrase("código",cabecera));
            PdfPCell cl2 = new PdfPCell(new Phrase("Dni",cabecera));
            PdfPCell cl3 = new PdfPCell(new Phrase("Cliente",cabecera));
          
            PdfPCell cl4 = new PdfPCell(new Phrase("Telefono",cabecera));

            cl1.setBorder(0);
            cl2.setBorder(0);
            cl3.setBorder(0);
            cl4.setBorder(0);

            tablacli.addCell(cl1);
            tablacli.addCell(cl2);
            tablacli.addCell(cl3);
            tablacli.addCell(cl4);

            tablacli.addCell(np.txtcodHistorial.getText());
            tablacli.addCell(np.txtHistorialDni.getText());
            tablacli.addCell(np.txtHistorialCliente.getText());
            tablacli.addCell(np.txtHistorialTelefono.getText());
            
            doc.add(tablacli);

            doc.add(Chunk.NEWLINE); // Agrega un salto de línea
            //membresias
            PdfPTable tablaMembre = new PdfPTable(4);
            tablaMembre.setWidthPercentage(100);
            tablaMembre.getDefaultCell().setBorder(0);
            float[] columnaMembre = new float[]{40f, 20f, 30f, 20f};
            tablaMembre.setWidths(columnaMembre);
            tablaMembre.setHorizontalAlignment(Element.ALIGN_LEFT);
            PdfPCell mem1 = new PdfPCell(new Phrase("Fecha Inicio",negrita));
            PdfPCell mem2 = new PdfPCell(new Phrase("Fecha Fin", negrita));
            PdfPCell mem3 = new PdfPCell(new Phrase("Precio Membresía", negrita));
            PdfPCell mem4 = new PdfPCell(new Phrase("Monto Pagado", negrita));

            mem1.setBorder(0);
            mem2.setBorder(0);
            mem3.setBorder(0);
            mem4.setBorder(0);

            tablaMembre.addCell(mem1);
            tablaMembre.addCell(mem2);
            tablaMembre.addCell(mem3);
            tablaMembre.addCell(mem4);

            for (ClienteHistorial cliente : clientes) {
                tablaMembre.addCell(cliente.getFechaInicio().toString());
                tablaMembre.addCell(cliente.getFechaFin().toString());
                tablaMembre.addCell(String.valueOf(cliente.getPrecioMembresia()));
                tablaMembre.addCell(String.valueOf(cliente.getMontoPagado()));
            }
            doc.add(tablaMembre);
            //Total inversion:
            Paragraph info =new Paragraph();
            info.add(Chunk.NEWLINE);
            info.add("Total invertido\n" + np.lblTotalHistorialCliente.getText());
            info.setAlignment(Element.ALIGN_RIGHT);
            doc.add(info);

            // Cerrar el documento
            doc.close();
            archivo.close();
          Desktop.getDesktop().open(file);

            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
