inherited FrmProdutos: TFrmProdutos
  Caption = 'Produtos'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 63
      Caption = 'Produtos'
      ExplicitWidth = 63
    end
  end
  inherited PageControl: TPageControl
    ActivePage = tshVisualizar
    inherited tshVisualizar: TTabSheet
      inherited pnlVisualizar: TPanel
        inherited pnlFiltros: TPanel
          object lblPesquisaNome: TLabel
            Left = 76
            Top = 10
            Width = 30
            Height = 13
            Caption = 'Nome'
          end
          object lblPesquisaCodigo: TLabel
            Left = 10
            Top = 10
            Width = 38
            Height = 13
            Caption = 'C'#243'digo'
          end
          object edtPesquisaNome: TEdit
            Left = 76
            Top = 31
            Width = 700
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
          end
          object edtPesquisaCodigo: TEdit
            Left = 10
            Top = 31
            Width = 60
            Height = 21
            Alignment = taRightJustify
            NumbersOnly = True
            TabOrder = 1
          end
        end
        inherited DBGrid: TDBGrid
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ID'
              Title.Caption = 'C'#243'digo'
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME'
              Title.Caption = 'Nome'
              Width = 350
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR'
              Title.Alignment = taCenter
              Title.Caption = 'Valor'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STATUS'
              Title.Alignment = taCenter
              Title.Caption = 'Status'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ESTOQUE'
              Title.Alignment = taCenter
              Title.Caption = 'Estoque'
              Width = 100
              Visible = True
            end>
        end
      end
    end
    inherited tshCadastro: TTabSheet
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
          object lblValor: TLabel
            Left = 10
            Top = 58
            Width = 27
            Height = 13
            Caption = 'Valor'
          end
          object lblEstoque: TLabel
            Left = 74
            Top = 58
            Width = 42
            Height = 13
            Caption = 'Estoque'
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
          object edtValor: TDBEdit
            Left = 10
            Top = 77
            Width = 60
            Height = 21
            DataField = 'valor'
            DataSource = DsCadastro
            TabOrder = 3
          end
          object edtEstoque: TDBEdit
            Left = 74
            Top = 77
            Width = 60
            Height = 21
            DataField = 'estoque'
            DataSource = DsCadastro
            TabOrder = 4
          end
        end
      end
    end
  end
end
