inherited FrmClientes: TFrmClientes
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 48
      Caption = 'Cliente'
      ExplicitWidth = 48
    end
  end
  inherited PageControl: TPageControl
    ActivePage = tshCadastro
    inherited tshVisualizar: TTabSheet
      inherited pnlVisualizar: TPanel
        inherited pnlFiltros: TPanel
          object lblPesquisaCodigo: TLabel
            Left = 10
            Top = 10
            Width = 38
            Height = 13
            Caption = 'C'#243'digo'
          end
          object lblPesquisaNome: TLabel
            Left = 76
            Top = 10
            Width = 30
            Height = 13
            Caption = 'Nome'
          end
          object edtPesquisaCodigo: TEdit
            Left = 10
            Top = 31
            Width = 60
            Height = 21
            Alignment = taRightJustify
            NumbersOnly = True
            TabOrder = 0
          end
          object edtPesquisaNome: TEdit
            Left = 76
            Top = 31
            Width = 700
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 1
          end
        end
        inherited DBGrid: TDBGrid
          Columns = <
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'id'
              Title.Caption = 'C'#243'digo'
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nome'
              Title.Caption = 'Nome'
              Width = 550
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'status'
              Title.Caption = 'Status'
              Width = 100
              Visible = True
            end>
        end
      end
    end
    inherited tshCadastro: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 792
      ExplicitHeight = 537
      inherited Panel2: TPanel
        inherited pnlCadastro: TPanel
          object lblCodigo: TLabel
            Left = 10
            Top = 10
            Width = 38
            Height = 13
            Caption = 'C'#243'digo'
          end
          object lblNome: TLabel
            Left = 74
            Top = 10
            Width = 30
            Height = 13
            Caption = 'Nome'
          end
          object edtCodigo: TDBEdit
            Left = 10
            Top = 29
            Width = 60
            Height = 21
            DataField = 'id'
            DataSource = DsCadastro
            Enabled = False
            TabOrder = 0
          end
          object edtNome: TDBEdit
            Left = 74
            Top = 29
            Width = 623
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            DataField = 'nome'
            DataSource = DsCadastro
            TabOrder = 1
          end
          object ckbStatus: TDBCheckBox
            Left = 709
            Top = 29
            Width = 66
            Height = 17
            Anchors = [akTop, akRight]
            Caption = 'Ativo?'
            DataField = 'status'
            DataSource = DsCadastro
            TabOrder = 2
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
        end
      end
    end
  end
  inherited DsPesquisa: TDataSource
    Left = 152
    Top = 432
  end
  inherited DsCadastro: TDataSource
    Left = 152
    Top = 488
  end
end
